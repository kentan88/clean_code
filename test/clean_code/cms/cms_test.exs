defmodule CleanCode.CMSTest do
  use CleanCode.DataCase

  alias CleanCode.CMS

  describe "events" do
    alias CleanCode.CMS.Event

    @valid_attrs %{description: "some description", published: true, title: "some title"}
    @update_attrs %{
      description: "some updated description",
      published: false,
      title: "some updated title"
    }
    @invalid_attrs %{description: nil, published: nil, title: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert CMS.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert CMS.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = CMS.create_event(@valid_attrs)
      assert event.description == "some description"
      assert event.published == true
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = CMS.update_event(event, @update_attrs)
      assert event.description == "some updated description"
      assert event.published == false
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_event(event, @invalid_attrs)
      assert event == CMS.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = CMS.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = CMS.change_event(event)
    end
  end
end
